from fastapi import Depends,APIRouter,Request,Response,status
from typing import Any, List, Optional
from sqlalchemy.orm import Session

from database.connection import get_db
from model.noteModel import Note
from repository import noteCRUD
from schema import noteSchema




note_Router = APIRouter(prefix="/note")



@note_Router.post("/create")
def create_note(payload:noteSchema.NoteBaseSchema,db:Session=Depends(get_db)):
    return noteCRUD.create(payload=payload,db=db)


@note_Router.get("/get")
def get_all_notes(db:Session=Depends(get_db)):
    return noteCRUD.get_all(db=db)


@note_Router.put("/update/{noteId}")
def update_note(noteId:int,payload:noteSchema.NoteBaseSchema,db:Session=Depends(get_db)):
    return noteCRUD.update(noteId=noteId,payload=payload,db=db)



@note_Router.delete('/delete/{noteId}')
def delete_note(noteId: int,  db: Session = Depends(get_db)):
    return noteCRUD.delete(noteId=noteId,db=db)
