from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)

@app.route('/')
def hello():
    return "Hello from Flask!"

@app.route('/metrics')
def metrics_endpoint():
    return metrics.do_export()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)