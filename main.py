import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import NearestNeighbors
import random
import json
import uuid
from fastapi import FastAPI, Request

app = FastAPI()

@app.post('/sign-up')
def sign_up(request):

    try:
        request_data = json.loads(request)
        username = request_data.get('username')
        device_id = request_data.get('device_id')

        ### 데이터베이스에 저장 추가
        # user = User(username=username, device_id=device_id, user_id=user_id)
        # user.save()
        user_id = str(uuid.uuid4())

        response_data = {
            # 'message': 'User registration successful',
            # 'user_id': user.user_id,
            'user_id': user_id,
        }
        # return JsonResponse(response_data, status=201)
        return response_data
    except Exception as e:
        response_data = {
            'error': 'User registration failed',
            'message': str(e),
        }
        # return JsonResponse(response_data, status=400)
        return response_data






@app.post('/load-list')
async def recommend_exercise(request: Request):
    try:
        request_data = await request.json()
        age = float(request_data.get('age'))

        gender = request_data.get('gender')

        if gender == "female":
            gender = 1
        else:
            gender = 0

        height = float(request_data.get('height'))
        weight = float(request_data.get('weight'))
        fat_percentage = float(request_data.get('fat_percentage'))
        lowest_blood_pressure = float(request_data.get('lowest_blood_pressure'))
        highest_blood_pressure = float(request_data.get('highest_blood_pressure'))
        grip_left = float(request_data.get('grip_left'))
        grip_right = float(request_data.get('grip_right'))
        bmi = (weight / ((height / 100) ** 2))

        ## 만약 악력이 입력되지 않아 0인 경우

        input_data = np.array([[age, gender, height, weight, fat_percentage, lowest_blood_pressure, highest_blood_pressure, grip_left, grip_right, bmi]])


        data = pd.read_csv('./data/exerciseData.csv')

        features = ['AGE', 'GENDER', 'HEIGHT', 'WEIGHT', 'FAT_PERCENTAGE', 'LOWEST_BLOOD_PRESSURE', 'HEIGHEST_BLOOD_PRESSURE', 'GRIP_LEFT', 'GRIP_RIGHT', 'BMI']

        X = data[features]

        scaler = StandardScaler()
        X_scaled = scaler.fit_transform(X)

        k = 7
        nn = NearestNeighbors(n_neighbors=k, metric='euclidean')
        nn.fit(X_scaled)

        scaled_test_data = scaler.transform(input_data)

        distances, indices = nn.kneighbors(scaled_test_data)

        similar_rows = data.iloc[indices[0]]

        similarity_scores = 1 / (1 + distances)

        similar_rows['Similarity Score'] = similarity_scores[0]
        similar_rows_sorted = similar_rows.sort_values(by='Similarity Score', ascending=False)

        most_similar_rows = similar_rows_sorted.head(7)


        before_exercise = set()
        main_exercise = set()
        after_exercise = set()

        for row in most_similar_rows.iterrows():
            before_exercise_data = row[1]['PRE_EX'].strip("[]'").split("', '")
            main_exercise_data = row[1]['EX'].strip("[]'").split("', '")
            after_exercise_data = row[1]['POST_EX'].strip("[]'").split("', '")

            before_exercise.update(before_exercise_data)
            main_exercise.update(main_exercise_data)
            after_exercise.update(after_exercise_data)

        before_exercise = list(before_exercise)
        main_exercise = list(main_exercise)
        after_exercise = list(after_exercise)


        before_exercise = [value for value in before_exercise if value != '']
        main_exercise = [value for value in main_exercise if value != '']
        after_exercise = [value for value in after_exercise if value != '']

        response_data = []

        for _ in range(1):
            random_before_exercise = random.choice(before_exercise)
            random_main_exercise = random.choice(main_exercise)
            random_after_exercise = random.choice(after_exercise)

            exercise_set = {
                    "ready_exercise": random_before_exercise,
                    "main_exercise": random_main_exercise,
                    "last_exercise": random_after_exercise
                }

            response_data.append(exercise_set)

        return response_data


    except Exception as e:
        response_data = {
            'error': 'Failed to process request data',
            'message': str(e),
        }
        return response_data
