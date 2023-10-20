Feature:
  @Create
  Scenario: Creacion del usuario
    Given url "https://petstore.swagger.io/v2/user/"
    And request read('json/altaUsuario.json')
    When method POST
    Then status 200
