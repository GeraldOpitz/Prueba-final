const express = require('express');
const axios = require('axios');
const fs = require('fs');

const app = express();

let ECR_URL;

try {
    const terraformData = JSON.parse(fs.readFileSync('ecr_data.json', 'utf-8'));
    ECR_URL = terraformData.ecr_repository_url;

    if (!ECR_URL) {
        throw new Error('La URL del repositorio ECR no está definida en ecr_data.json');
    }
} catch (error) {
    console.error('Error al leer o parsear ecr_data.json:', error);
    process.exit(1);
}

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
