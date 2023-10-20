Feature:
  Scenario: Consulta de un usuario
    * call read('creacionUsuario.feature@Create')
    * def user = read('json/altaUsuario.json')
    * def username = user.username
    Given url 'https://petstore.swagger.io/v2/user/'
    And path username
    When method GET
    Then status 200
    And match $ == user
