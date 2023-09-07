from database.connection import Base
from sqlalchemy import Column, String, Integer
from sqlalchemy.sql import func


class Note(Base):
    __tablename__ = 'note'
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    content = Column(String, nullable=False)
    category = Column(String, nullable=True)
