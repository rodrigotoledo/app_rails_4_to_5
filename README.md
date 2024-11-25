# Docker Instructions

Need To Clean All Your Docker?

```bash
docker system prune -a --volumes -f
rm .db-created
rm .db-seeded
rm Gemfile.lock
```

## Putting In Development Mode

Whereas It Is Necessary To Run With Your User, Run

```bash
id -u
```

And Change The Dockerfile.Development File With The Value You Found

So Build You Just Need To Run The First Time:

```bash
docker compose -f docker-compose.development.yml build
```

And To Climb The Application Rode:

```bash
docker compose -f docker-compose.development.yml up
docker compose -f docker-compose.development.yml down
docker compose -f docker-compose.development.yml run app bash
```

Maybe you need to run bash just to install bundler with the correct version, because rails 4 needs `1.17.3`, so enter in the bash of the application with

```bash
docker compose -f docker-compose.development.yml run app bash
```

And there install with:

```bash
bundle _1.17.3_ install
```

Recompose the database:

```bash
docker compose -f docker-compose.development.yml run app rake db:drop db:create db:migrate db:seed
```

Migrate the database:

```bash
docker compose -f docker-compose.development.yml run app rake db:create
docker compose -f docker-compose.development.yml run app rake db:migrate
docker compose -f docker-compose.development.yml run app rake db:seed
docker compose -f docker-compose.development.yml run app rake db:rollback
docker compose -f docker-compose.development.yml run app rake db:rollback db:migrate
```

## Rails Commands

Example Of Interaction Between Computer And Container:

```bash
docker compose -f docker-compose.development.yml run app rails d model comment
docker compose -f docker-compose.development.yml run app rails c
```

## Testing

For Tests For Example Run `Guard`:

```bash
docker compose -f docker-compose.development.yml run app bundle exec guard
```

For Migrations (Remembering That You May Need To Run Both In Development And Test):

```bash
docker compose -f docker-compose.development.yml run app rake db:migrate
```

## Security (in future versions)

It's a good practice to use annotaterb, brakeman and rubocop when you are developing. You can setup your own configuration using the example that exists in `.vscode.example` renaming to `.vscode`. Also running docker command to annotaterb, cover with rubocop and brakeman:

```bash
docker compose -f docker-compose.development.yml run app bundle exec annotaterb models
docker compose -f docker-compose.development.yml run app bin/rubocop -A
docker compose -f docker-compose.development.yml run app bundle exec brakeman
```

or with just one command:

```bash
docker compose -f docker-compose.development.yml run app bundle exec rubocop -A ; docker compose -f docker-compose.development.yml run app bundle exec brakeman ; docker compose -f docker-compose.development.yml run app bundle exec annotaterb models
```

## Putting Down

If You Want To Stop The Services:

```bash
docker compose -f docker-compose.development.yml down
```

## More

Ruby On Rails With Docker And Docker-Compose In Development Mode

Usually There Are Questions And Details On How To Develop Using Docker And Docker-Compose In Development Mode: I Need To Build, Go Up And Down All The Time ... Calm Down Let's Go

## Git Flow

This project uses the Git Flow branching model to manage development and releases. Below are the basic commands to get started with Git Flow.

### Git Flow Branches

- **`main`**: The production-ready branch.
- **`staging`**: The staging-ready branch.
- **`develop`**: The branch where features are integrated.
- **`feature/{feature-name}`**: Branches for developing new features.
- **`release/{version}`**: Branches for preparing a new release.
- **`hotfix/{fix-description}`**: Branches for urgent fixes.

1 . Start a New Feature:

```bash
git flow feature start {feature-name}
```

2 . Finish a Feature:

```bash
git flow feature finish {feature-name}
```

Replace {feature-name} with your feature name.

3 . Start a Release:

```bash
git flow release start {version}
```

Replace {version} with the version name.

4 . Finish a Release:

```bash
git flow release finish {version}
```

5 . Start a Hotfix:

```bash
git flow hotfix start {fix-description}
```

6 . Finish a Hotfix:

```bash
git flow hotfix finish {fix-description}
```