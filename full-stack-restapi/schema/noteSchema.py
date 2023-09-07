from typing import List
from pydantic import BaseModel


class NoteBaseSchema(BaseModel):
    title : str
    content : str
    category : str

    class Config:
        orm_mode = True
        allow_population_by_field_name = True
        arbitrary_types_allowed = True
