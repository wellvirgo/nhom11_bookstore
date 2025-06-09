package com.nhom11.Book_Store.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nhom11.Book_Store.model.Address;
import com.nhom11.Book_Store.model.User;
import com.nhom11.Book_Store.repository.AddressRepository;

import jakarta.transaction.Transactional;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AddressService {
    AddressRepository addressRepository;
    public List<Address> getAllAddressByUserId(Long userId) {
        return addressRepository.findByUserId(userId);
    }
    public Address getAddressById(Long id){
        return addressRepository.findById(id).orElse(null);
    }
    public Address saveAddress(Address address) {
        return addressRepository.save(address);
    }
    @Transactional
    public void setAllAddressDefaultFalse(Long userId) {
        addressRepository.updateAllDefaultFalse(userId);
    }
    public Address getAddressDefaultByUser(User user) {
        return addressRepository.findByUserAndIsDefaultTrue(user);
    }
    
}
