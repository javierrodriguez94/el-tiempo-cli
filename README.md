# el-tiempo-cli

el-tiempo-cli is a client to get weather forecast information from a API provider
This comes with a provider implementation for tiempo.com API and configuration for Barcelona cities

```eltiempo -FUNCTION CITY```

You can use that three functions:

  **-today** to get maximun and minumun temperatures of today in the city

  **-av_min** to get minumun temperatures average of next week in the city

  **-av_max** to get maximun temperatures average of next week in the city


## Setup with Docker

These instructions will get you a copy of the project easy to use with Docker

### Prerequisites

You must have Docker installed

You can follow the official guides to install docker here: https://docs.docker.com/install/

### Installing

First of all you have to clone this repo

```
git clone git@github.com:javierrodriguez94/el-tiempo-cli.git
```

And them lets build the docker image.

```
cd el-tiempo-cli
docker build -t el-tiempo-cli .
```

And run the container with the affiliate_id of tiempo.com API

```
docker run -it -e Tiempo::AFFILIATE_ID="XXXXXXXXX" el-tiempo-cli
```

Or if you want to change the division param to get other cities available:

```
docker run -it -e Tiempo::AFFILIATE_ID="XXXXXXXXX" -e Tiempo::DIVISION=NNN el-tiempo-cli
```

### Usage

After ```docker run -it```  you are in the docker container terminal so you can use the app like this:

```
eltiempo -today 'Barcelona'
eltiempo -av_min 'Barcelona'
eltiempo -av_max 'Barcelona'
```


## Setup without Docker

To use it without Docker follow these instructions


### Prerequisites

You must have Ruby installed


### Installing

First of all you have to clone this repo

```
git clone git@github.com:javierrodriguez94/el-tiempo-cli.git
```
You have to install some dependencies

```
cd el-tiempo-cli
bundle install
```

Set the enviroment variables

```
export Tiempo::HOST          = "http://api.tiempo.com/index.php?"
export Tiempo::DIVISION      = 102
export Tiempo::API_LANG      = "es"
export Tiempo::AFFILIATE_ID  = "XXXXXXXXX"
```
You can change also the division, 102 is for Barcelona


### Usage

Now you can use the app like this:

```
./eltiempo -today 'Barcelona'
./eltiempo -av_min 'Barcelona'
./eltiempo -av_max 'Barcelona'
```
 
Or add the eltiempo file to your path to avoid using ./ and be able to execute it from any directory

### Running the tests

To run the unit test:

```
rspec
```
