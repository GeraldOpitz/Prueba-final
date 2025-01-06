const express = require('express');
const axios = require('axios');
const fs = require('fs');

const app = express();

const terraformData = JSON.parse(fs.readFileSync('ecr_data.json', 'utf-8'));
const ECR_URL = terraformData.ecr_repository_url;

app.get('/fetch-data', async (req, res) => {
    try {
        const response = await axios.get(ECR_URL);
        res.json(response.data);
    } catch (error) {
        console.error('Error al interactuar con ECR:', error);
        res.status(500).send('Error al obtener datos de la aplicación en ECR');
    }
});

const PORT = 8080;
app.listen(PORT, () => {
    console.log(`API corriendo en el puerto ${PORT}`);
    console.log(`Conectando a ECR en: ${ECR_URL}`);
});
