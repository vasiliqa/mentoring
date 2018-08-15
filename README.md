# mentoring

## Installation and running

Please run locally `bundle install mailcatcher`
https://github.com/sj26/mailcatcher:
Please don't put mailcatcher into your Gemfile. It will conflict with your applications gems at some point.

Configure server:
Change ip in config/provision/production if needed
local - ansible-playbook --inventory=config/provision/production config/provision/provision.yml
Don't forget to add it to gmail.com white list

remote - ssh root@server_ip
nano ../home/mentoring/apps/mentoring_production/shared/config/environment.production
Fill it with correct variables - see in TODO.txt

Deploy the app:
local - don't forget to comment/uncomment last 2 lines in config/deploy.rb
bundle exec cap production deploy --trace

Restore db from backup
local - scp ../backups/mentoring/08.04.2018/4b943051-616c-444b-b3be-5fbf61edcfdd root@207.154.245.159:/home/mentoring/apps/mentoring_production

remote - cd ../home/mentoring/apps/mentoring_production/
sudo su postgres
pg_restore -d mentoring_production 4b943051-616c-444b-b3be-5fbf61edcfdd

Get logs
remote - cd ../home/mentoring/apps/mentoring_production/current/log
tail -f production.log

Rails console
ssh mentoring@207.154.245.159
~/apps/mentoring_production/current$ bundle exec rails console production

## Installation with Docker
If you prefer Docker, it is possible to deploy an app into docker environment. You will need to copy `docker-compose.yml` and all bash scripts from `script` folder into you production server and additionally you will need to create secrets with environment variables. You will need to check `docker-compose.yml` section `secrets:` at the bottom of file and generate all these secrets. They could be placed in `secrets` folder. So you should gain a such structure:
```
docker-compose.yml
scripts/
secrets/
```

## Production environment variables
* `HTTP_HOST` - your domain, i.e. `nastavnik54.ru`

### Databases variables
* `DB_HOST` - database host
* `DB_NAME` - database name
* `DB_USERNAME` - database user role
* `DB_USERPASS` - database user password
* `REDIS_HOST`

### Mailer configuration
There are two options: you can use postfix or gmail smtp. First will be provided via one more installed container and it
goes by default. To use `gmail` you'll need to set `GMAIL_USER` variable in compose file.

Keep in mind that gmail smtp has some [restrictions](https://nodemailer.com/usage/using-gmail/)
* `GMAIL_USER` (optional)
* `GMAIL_PASS` (optional)
* `MAILER_SENDER` - This is a string which represents outgoing mails `sender` field, ie `"Программа Детский дом" <nastavnichestvo@inbox.ru>`. You need to change to whatever you need

### Cookies token
* `SECRET_KEY_BASE` - key that used for verifying the integrity of signed cookies. Can be generated via `bin/rake secret`
