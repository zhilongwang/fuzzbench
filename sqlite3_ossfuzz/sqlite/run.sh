TRIGGER_VARIABLES=true ./sqlite3 Test2.db ".read demo.sql"
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out ./sqlite3 Test2.db ".read demo.sql"


