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
	model "motel-backend/model/bill"
	repository "motel-backend/repository/bill"
	"time"
)

type billService struct {
	billRepo repository.BillInfrastRepo
}

// FetchBill implements repository.BillServiceRepo.
func (bill *billService) FetchBill() ([]model.Bill, error) {
	var bills, errorDB = bill.billRepo.GetAllBill()
	if errorDB != nil {
		return []model.Bill{}, errorDB
	}
	fmt.Printf("\n\n\n\nhung????????????????????????????????// %s\n\n", time.DateTime)

	fmt.Printf("\n----\n%v", bills)

	return bills, nil
}

func NewBillService(repo repository.BillInfrastRepo) repository.BillServiceRepo {
	return &billService{billRepo: repo}
}
