@Requests
Feature:Test RapidApi Shortener
  Background:
   Given  url urlShort
    And path 'shorten'
    * def body = {"url":"https://crowdar.com.ar"}
    * def key = {"x-rapidapi-key":"5bc1a34c40mshe27d32ebba28f93p1f3a18jsn222d7956a53b"}

  @Valid200
  Scenario Outline: Se valida que la respuesta del Status 200 es un string
    And headers key
    And request body
    And method POST
    And status 200
    Then  match <response>
    Examples:
      |response|
      |response.result_url =='#string'|

  @Empty
  Scenario Outline: Se valida la respuesta del Status 400 url vacia
    And headers key
    And request {}
    And method POST
    And status 400
    Then  match <response>
    Examples:
      |response|
      |response ==read('classpath:examples/users/response/sinUrl.json')|

  @InvalidUrl
  Scenario Outline: Se valida la respuesta del Status 400 url no valida
    * def invalidUrl = {"url": "sdfadfadsfdfsdf"}
    And headers key
    And request invalidUrl
    And method POST
    And status 400
    Then  match <response>
    Examples:
      |response|
      |response ==read('classpath:examples/users/response/invalidUrl.json')|

  @InvalidToken
  Scenario Outline: Se valida la respuesta del Status 403 Token no valido
    And header x-rapidapi-key = '<key>'
    And request body
    And method POST
    And status 403
    Then  match <response>
    Examples:
      | key                 |                                                response                                                             |
      | asdasdas       |response ==read('classpath:examples/users/response/invalidToken.json')|
