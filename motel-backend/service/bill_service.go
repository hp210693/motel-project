/*
MIT License

Copyright (c) 2023 Hung Phan (@hp210693)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
package service

import (
	"fmt"
	"log"
	model "motel-backend/model"
	repository "motel-backend/repository"
)

type billService struct {
	billRepo repository.BillInfrastRepo
}

func (bill *billService) FetchAllBill() ([]model.Bill, error) {
	var bills, err = bill.billRepo.GetAllBill()
	if err != nil {
		return []model.Bill{}, fmt.Errorf("[%s] -- %s", LAYER, err)
	}

	log.Printf("[%s] Backend got all bill from the database is ok -- we have %v user in system\n", LAYER, len(bills))
	return bills, nil
}

func NewBillService(repo repository.BillInfrastRepo) repository.BillServiceRepo {
	return &billService{billRepo: repo}
}
