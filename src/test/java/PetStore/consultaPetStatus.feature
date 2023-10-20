Feature:
  Scenario: Consultar lista mascotas vendidas
    Given url 'https://petstore.swagger.io/v2/pet/findByStatus?status=sold'
    When method GET
    Then status 200
    And def responseList = response
    And def petData = []

    And eval
    """
    for (var i = 0; i < responseList.length; i++) {
      var pet = responseList[i];
      karate.log('{' + pet.id + ', ' + pet.name + '}');
      var petInfo = { id: pet.id, name: pet.name };
      petData.push(petInfo);
    }
    """

    # Convierte el array de objetos en una cadena JSON
    And def petDataJson = karate.toJson(petData)
    And eval
"""
karate.log('Contenido de petDataJson: ', petDataJson);
"""

    # Convierte la cadena JSON en un valor de tipo java.lang.String
    And def jsonString = petDataJson

    # Define el nombre del archivo JSON que deseas guardar en la carpeta de recursos
    And def fileName = 'mascotas.json'

    # Utiliza karate.write para guardar la cadena JSON en el archivo en la carpeta de recursos
    And karate.write(jsonString,'../src/test/resources/' + fileName)

    # Luego, puedes imprimir la ubicación del archivo si deseas verificar que se ha guardado correctamente
    And print 'JSON de mascotas guardado en:', '../src/test/resources/' + fileName
