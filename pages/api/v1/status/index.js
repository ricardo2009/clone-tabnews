function status(request, response) {
  response.status(200).json({ Teste: "Meu primeiro endpoint na Vercel!" });
}

export default status;
