# mentoring

Please run locally `bundle install mailcatcher`
https://github.com/sj26/mailcatcher:
Please don't put mailcatcher into your Gemfile. It will conflict with your applications gems at some point.

Configure server:
local - ansible-playbook --inventory=config/provision/production config/provision/provision.yml

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
bundle exec rails c
