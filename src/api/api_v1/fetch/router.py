from fastapi import APIRouter, Request
from fastapi.responses import HTMLResponse
from fastapi.responses import FileResponse
from fastapi.templating import Jinja2Templates

router = APIRouter()
templates = Jinja2Templates(directory="./static")


@router.get("/v6.js")
async def fetch_script(request: Request):
    file_path = "./static/v6.js"
    return FileResponse(file_path, media_type="application/streaming")


@router.get("/homepage", response_class=HTMLResponse)
async def lpc():
    html = """<!DOCTYPE html>
<html>
<head>
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-WLM8P8NW');</script>
<!-- End Google Tag Manager -->
</head>
<body>

<h1>My First Heading</h1>
<p>My first paragraph.</p>

</body>
</html>"""
    return html