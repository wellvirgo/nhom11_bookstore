package com.nhom11.Book_Store.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nhom11.Book_Store.model.Address;
import com.nhom11.Book_Store.service.AddressService;


@Controller
@RequestMapping("/user/address")
public class AddressController {
    @Autowired
    private AddressService addressService;

    //đặt địa chỉ làm mặc địnhđịnh
    @PostMapping("/default")
    public ResponseEntity<?> defaultAdress(@RequestBody Map<String,Object> payload) {
        Long addressId = Long.valueOf(payload.get("addressId").toString());
        Address address = addressService.getAddressById(addressId);
        addressService.setAllAddressDefaultFalse(address.getUser().getId());
        address.setDefault(true);
        System.out.println("isDefault sau khi lưu: " + address.isDefault());
        addressService.saveAddress(address);
        return ResponseEntity.ok("Đặt địa chỉ làm mặc định thành công với ID: " + addressId);
    }
    
}
