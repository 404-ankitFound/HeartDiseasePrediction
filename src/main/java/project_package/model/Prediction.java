package project_package.model;

import java.sql.Date;

public class Prediction {

    private String userid;
    private Date predictionDate;
    private int age;
    private int restingBP;
    private int cholesterol;
    private int result;


    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public Date getPredictionDate() {
        return predictionDate;
    }

    public void setPredictionDate(Date predictionDate) {
        this.predictionDate = predictionDate;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getRestingBP() {
        return restingBP;
    }

    public void setRestingBP(int restingBP) {
        this.restingBP = restingBP;
    }

    public int getCholesterol() {
        return cholesterol;
    }

    public void setCholesterol(int cholesterol) {
        this.cholesterol = cholesterol;
    }

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }
}