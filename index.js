require('dotenv').config()
const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const dialogflow = require('dialogflow')
const { v4: uuidv4 } = require('uuid')
const path = require('path')

// Corrige o caminho para o arquivo de credenciais
const credentialsPath = path.resolve(__dirname, process.env.GOOGLE_APPLICATION_CREDENTIALS)
const credentials = require(credentialsPath)

const app = express()
app.use(cors())
app.use(bodyParser.json())

const sessionClient = new dialogflow.SessionsClient({
  keyFilename: credentialsPath,
})

app.get('/', (req, res) => {
  res.send('Backend funcionando!')
})

app.post('/dialogflow', async (req, res) => {
  const message = req.body.message
  const sessionId = uuidv4()

  const sessionPath = sessionClient.sessionPath(credentials.project_id, sessionId)

  const request = {
    session: sessionPath,
    queryInput: {
      text: {
        text: message,
        languageCode: 'pt-br',
      },
    },
  }

  try {
    const responses = await sessionClient.detectIntent(request)
    const result = responses[0].queryResult
    res.json({ reply: result.fulfillmentText })
  } catch (error) {
    console.error('Erro ao enviar para Dialogflow:', error)
    res.status(500).json({ error: 'Erro no Dialogflow' })
  }
})

const PORT = process.env.PORT || 3001
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`)
})
