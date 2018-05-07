
from mitmproxy import http

def request(flow: http.HTTPFlow) -> None:
    if flow.request.pretty_host == "example.com":
        flow.request.host = "XXXX"
