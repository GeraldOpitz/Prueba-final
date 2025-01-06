const express = require('express');
const axios = require('axios');
const ecrUrl = process.env.ECR_REPOSITORY_URL;
const app = express();


if (!ecrUrl) {
    console.error('ECR_REPOSITORY_URL no está definido.');
    process.exit(1);
  }

app.get('/fetch-data', async (req, res) => {
    try {
        const response = await axios.get(ecrUrl);
        res.json(response.data);
    } catch (error) {
        console.error('Error al interactuar con ECR:', error);
        res.status(500).send('Error al obtener datos de la aplicación en ECR');
    }
});

const PORT = 8080;
app.listen(PORT, () => {
    console.log(`API corriendo en el puerto ${PORT}`);
    console.log(`Conectando a ECR en: ${ecrUrl}`);
});
