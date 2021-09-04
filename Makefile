TEST_SETTINGS=project.settings

.PHONY: fresh_install, clean, run, shell, test, pylint, help

# target: fresh_install - fresh install of the project including python packages, migration, db data, run application
fresh_install:
	pip install -r requirements.txt
	python project/manage.py migrate
	# python project/manage.py loaddata project_init.json  # or psql -f project_init.sql ...
	python project/manage.py runserver

# target: run - migrate and runserver
run:
	python project/manage.py migrate
	python project/manage.py runserver

# target: shell - run shell_plus
shell:
	python project/manage.py shell_plus

# target: test - run all tests + generate report and coverage
test:
	pytest project/tests/ --ds=${TEST_SETTINGS} --junitxml report/test_out.xml --cov=project/ --cov-config=.coveragerc

# target: pylint - run pylint with .pylintrc and msg template
pylint:
	pylint project/ project/tests --rcfile=.pylintrc '--msg-template={path} {line} [{msg_id}({symbol}), {obj}] {msg}'

# target: clean - remove all temp files
clean:
	rm -rf project/report

help:
	grep "^# target:" Makefile



## target: fresh_install - fresh install of the project including python packages, migration, db data, run application
#fresh_install: sync
#	python manage.py loaddata project_init.json  # or psql -f project_init.sql ...
#	python manage.py runserver
#
## target: sync - pip install and migrate
#sync:
#	pip install -r requirements.txt
#	python manage.py migrate
#
#
#output.log: main.py
#	python main.py
#
#
#up:
#	docker-compose -f docker-compose.yml up -d
#
#logs-api:
#	docker-compose -f docker-compose.yml logs --tail=100 -f api
#
#login-api:
#	docker-compose exec api /bin/bash
#
#test:
#	docker-compose exec lms bash -c 'source /edx/app/edxapp/edxapp_env && cd /edx/app/edxapp/edx-platform && paver test_system -t lms/djangoapps/ed2go --settings=test_ed2go'
