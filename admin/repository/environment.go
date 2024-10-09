package repository

import (
	"admin/entity/environment"
	"encoding/json"
	"os"
)

type Environment struct {
	FileName string
}

func (e *Environment) GetImageBaseUrlString() (string, error) {
	data, err := os.ReadFile(e.FileName)
	if err != nil {
		return "", err
	}

	config := environment.Config{}
	err = json.Unmarshal(data, &config)
	if err != nil {
		return "", err
	}
	
	return config.ImageBaseURL, nil
}
