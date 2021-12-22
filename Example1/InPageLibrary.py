import json
import js


class InPageLibrary:
    def open_browser(self, url):
        js.postMessage(json.dumps({"keyword": "open_browser", "url": url}))

    def type_text(self, locator, text):
        js.postMessage(
            json.dumps({"keyword": "type_text", "locator": locator, "text": text})
        )

    def click(self, locator):
        print(locator)
        js.postMessage(json.dumps({"keyword": "click", "locator": locator}))

    def get_text(self, locator):
        js.postMessage(json.dumps({"keyword": "get_text", "locator": locator}))
