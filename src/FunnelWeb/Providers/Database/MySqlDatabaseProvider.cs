using System;
using System.Data;
using System.Data.SqlClient;

using DbUp;
using DbUp.Builder;

using FluentNHibernate.Cfg.Db;

using FunnelWeb.DatabaseDeployer;
using FunnelWeb.Providers.Database.Sql;

using MySql.Data.MySqlClient;

namespace FunnelWeb.Providers.Database
{
    public class MySqlDatabaseProvider : IDatabaseProvider
    {
        public string DefaultConnectionString
        {
            get { return @"database=FunnelWeb;server=localhost;username=FunnelWebDbUser;password=FD28DE2EB96E41D79EC34B336F;"; }
        }

        public bool SupportSchema
        {
            get { return true; }
        }

        public bool SupportFuture
        {
            get { return true; }
        }

        public bool SupportsFullText
        {
            get { return true; }
        }

        /// <summary>
        /// Tries to connect to the database.
        /// </summary>
        /// <param name="connectionString">The connection string.</param>
        /// <param name="errorMessage">Any error message encountered.</param>
        /// <returns></returns>
        public bool TryConnect(string connectionString, out string errorMessage)
        {
            try
            {
                if (string.IsNullOrEmpty(connectionString))
                {
                    errorMessage = "No connection string specified";
                    return false;
                }

                var csb = new MySQLConnectionStringBuilder();
                csb.FromAppSetting(connectionString);

                errorMessage = "";
                using (var connection = new MySqlConnection(connectionString))
                {
                    connection.Open();

                    new MySqlCommand("select 1", connection).ExecuteScalar();
                }
                return true;
            }
            catch (Exception ex)
            {
                errorMessage = ex.Message;
                return false;
            }
        }

        public IPersistenceConfigurer GetDatabaseConfiguration(IConnectionStringSettings connectionStringSettings)
        {
            return MySQLConfiguration.Standard.ConnectionString(connectionStringSettings.ConnectionString)
                                     .Driver<ProfiledSqlClientDriver>()
                                     .ShowSql()
                                     .DefaultSchema(connectionStringSettings.Schema);
        }

        public Func<IDbConnection> GetConnectionFactory(string connectionString)
        {
            return () => new MySqlConnection(connectionString);
        }

        public UpgradeEngineBuilder GetUpgradeEngineBuilder(string connectionString, string schema)
        {
            return DeployChanges.To
                                .MySqlDatabase(GetConnectionFactory(connectionString), schema);
        }
    }
}