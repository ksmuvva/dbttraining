# DBT Training Project

This is a dbt (data build tool) training project configured for learning and development purposes.

## Project Structure

```
dbttraining/
├── models/
│   ├── staging/          # Staging models (views)
│   └── marts/           # Final data marts (tables)
├── analyses/            # Ad-hoc analyses
├── tests/              # Custom tests
├── seeds/              # CSV files to load as tables
├── macros/             # Reusable SQL macros
├── snapshots/          # Slowly changing dimension snapshots
├── dbt_project.yml     # Project configuration
└── profiles.yml        # Database connection profiles
```

## Getting Started

1. **Install dbt**: 
   ```bash
   pip install dbt-core dbt-postgres
   ```

2. **Set up environment variables** (for database connection):
   ```bash
   export DBT_USER=your_username
   export DBT_PASSWORD=your_password
   export DBT_DATABASE=your_database
   ```

3. **Test your connection**:
   ```bash
   dbt debug
   ```

4. **Install dependencies**:
   ```bash
   dbt deps
   ```

5. **Run your models**:
   ```bash
   dbt run
   ```

6. **Test your models**:
   ```bash
   dbt test
   ```

## Database Configuration

This project is configured to work with PostgreSQL by default. The connection details are defined in `profiles.yml` and use environment variables for security.

### Supported Databases

The profiles.yml file includes example configurations for:
- PostgreSQL (default)
- Snowflake
- BigQuery

## Development

- Staging models are materialized as views for fast development
- Marts models are materialized as tables for production use
- Test failures are stored for debugging (see `tests` configuration in `dbt_project.yml`)

## Project Variables

- `start_date`: Set to '2020-01-01' for historical data processing

## Learning Resources

- [dbt Documentation](https://docs.getdbt.com/)
- [dbt Learn](https://learn.getdbt.com/)
- [dbt Community](https://community.getdbt.com/)