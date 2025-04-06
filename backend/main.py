from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import requests
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

app = FastAPI()

# Get secret key from environment variable
SECRET_KEY = os.getenv("SECRET_KEY", "default_secret")

# Bitcoin price API
BITCOIN_API_URL = "https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT"
#BITCOIN_API_URL = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
# Allow CORS for all origins (or restrict to specific origins for security)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/price")
async def get_bitcoin_price():
    try:
        response = requests.get(BITCOIN_API_URL)
        data = response.json()

        print("API Response:", data)

      #  price = data["bitcoin"]["usd"]
        price = data["price"]
 
        return {"price": price}
    except Exception as e:
        return {"error": str(e)}

@app.get("/secret")
def get_secret():
    return {"secret_key": SECRET_KEY}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)




