from sqlalchemy.orm import Session
from model.noteModel import Note
from schema import noteSchema
from typing import Dict, Any
from fastapi import HTTPException, status


def create(payload: noteSchema.NoteBaseSchema, db: Session):
    try:
        new_note = Note(**payload.dict())
        db.add(new_note)
        db.commit()
        db.refresh(new_note)
        return {"status": "success", "note": new_note}
    except Exception as e:
        return {"error": f"An error occurred :{str(e)}"}
    finally:
        db.close()


def get_all(db: Session):
    try:
        return db.query(Note).all()
    except Exception as e:
        return {"error": f"An error occurred :{str(e)}"}
    finally:
        db.close()


def update(noteId: int, payload: noteSchema.NoteBaseSchema, db: Session):
    try:
        note_query = db.query(Note).filter(Note.id == noteId)
        db_note = note_query.first()

        if not db_note:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail=f"not found")
        update_data = payload.dict(exclude_unset=True)
        note_query.filter(Note.id == noteId).update(
            update_data, synchronize_session=False)
        db.commit()
        db.refresh(db_note)
        return {"status": "success updated", "note": db_note}
    except Exception as e:
        return {"error": f"An error occurred :{str(e)}"}
    finally:
        db.close()



def delete(noteId: int, db: Session):
    try:
        note_query = db.query(Note).filter(Note.id == noteId)
        db_note = note_query.first()

        if not db_note:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail=f"not found")

        note_query.delete(synchronize_session=False)
        db.commit()
        return {"status": "success deleted"}
    except Exception as e:
        return {"error": f"An error occurred :{str(e)}"}
    finally:
        db.close()
