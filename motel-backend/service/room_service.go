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
	model "motel-backend/model"
	repository "motel-backend/repository"
)

type roomService struct {
	roomRepo repository.RoomInfrastRepo
}

func NewRoomService(repo repository.RoomInfrastRepo) repository.RoomServiceRepo {
	return &roomService{roomRepo: repo}
}

// FetchAllRoom implements repository.RoomServiceRepo.
func (room *roomService) FetchAllRoom() ([]model.Room, error) {

	var rooms, error = room.roomRepo.GetAllRoom()

	if error != nil {
		return rooms, error
	}

	fmt.Printf("\n\n\n--roomService FetchAllRoom--\n\n\n%v", rooms)

	return rooms, nil
}
