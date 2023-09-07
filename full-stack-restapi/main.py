import uvicorn
from fastapi import FastAPI
from database.connection import engine

from model import noteModel
from route.noteRout import note_Router

# db config
noteModel.Base.metadata.create_all(bind=engine)

# app instance
app=FastAPI()

# router config
app.include_router(note_Router)


@app.get("/")
def home():
    return {"msg":"Welcome to rest api "}


if __name__ == "__main__":
    uvicorn.run("main:app",reload=True,port=5000)
