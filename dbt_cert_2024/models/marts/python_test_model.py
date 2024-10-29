import datetime

def check_weekend(date_col):
    date_value = datetime.datetime.strptime(str(date_col), "%Y-%m-%d")
    is_weekend = date_value.date().weekday() in [5, 6]
    return is_weekend
	
def model(dbt, session):
	
    cram_dataset_with_holidays = dbt.ref("fct_z4br_dataset")
	
    df = cram_dataset_with_holidays.pandas_api()
    df["is_weekend"] = df["date"].apply(check_weekend)
    df = df.to_spark()
	
    return df