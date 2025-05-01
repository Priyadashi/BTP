from flask import Flask, request, jsonify
import joblib
app   = Flask(__name__)
model = joblib.load("model.pkl")

@app.route("/predict", methods=["POST"])
def predict():
    data = request.json["data"]
    pred = model.predict([data])[0]
    return jsonify({"prediction": int(pred)})

if __name__=="__main__":
    app.run(host="0.0.0.0", port=5000)
