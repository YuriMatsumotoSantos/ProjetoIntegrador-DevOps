# Imagem base leve solicitada
FROM python:3.9-slim

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos de requisitos e instala as dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o código da aplicação
COPY app.py .

# Expõe a porta que o Flask usa
EXPOSE 5000

# Comando para iniciar a aplicação
CMD ["python", "app.py"]