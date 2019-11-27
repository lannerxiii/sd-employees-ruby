
## Instalación:

### Global

```
sudo apt-get install ruby-full (Ruby)
sudo apt-get install libmysqlclient-dev (librería para que funcione la gema mysql2)
gem install bundle (programa para instalar las gemas de un Gemfile)
```

### Dentro de la carpeta del proyecto

```
bundle install (instala las gemas desde Gemfile)
rake db:create:all (crea la base de datos, configurar config/db.yml para el acceso a la misma)
rake db:migrate (corre las migraciones en la base de datos, configurar config/db.yml para el acceso a la misma)
rake db:seed (corre el archivo de seeds (db/seeds.rb) para llenar las tablas con datos)
```

## Levantar la aplicación

Dentro de la carpeta del proyecto
```
ruby app.rb
```

Ingresar a http://localhost: puerto que diga la consola al ejecutar el comando anterior

## Problemas de conexión a MySQL por el método de autenticación
Las credenciales son de ejemplo
```
mysql> mysql -u root -p
mysql> use mysql;
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'very_strong_password';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'administrator'@'localhost' IDENTIFIED BY 'very_strong_password';
```


## Problemas con base de datos

Para borrar todo y volver a restaurar la base de datos:
```
rake db:drop:all (dropea la base de datos entera)
rake db:create:all (crea la base de datos)
rake db:migrate (corre las migraciones en la base de datos, configurar config/db.yml para el acceso a la misma)
rake db:seed (corre el archivo de seeds (db/seeds.rb) para llenar las tablas con datos)
```
