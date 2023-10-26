test("espero que 1 seja 1", () => {
  expect(1).toBe(1); // cenario de teste PASS
  // expect(2).toBe(1); // cenario de teste FAIL
  // expect = valor gerado  dinamicamente

  // o valor declaro no expect é declarado no toBe
  // toBe = valor esperado
  // o valor que vem computado no sistema de forma dinamica é declarado no expect

  // por exemplo em um sistema de calculadora onde o valor esperado é 1 em um cenario mais por algum motivo o valor computado é 2, o teste vai falhar!
});
