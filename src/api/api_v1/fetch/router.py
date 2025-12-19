from fastapi import APIRouter, Request
from fastapi.responses import FileResponse
from fastapi.templating import Jinja2Templates

router = APIRouter()
templates = Jinja2Templates(directory="./static")


@router.get("/v6.js")
async def fetch_script(request: Request):
    file_path = "./static/v6.js"
    return FileResponse(file_path, media_type="application/streaming")
