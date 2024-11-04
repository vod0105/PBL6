package com.example.BE_PBL6_FastOrderSystem.security.user;

import com.example.BE_PBL6_FastOrderSystem.entity.User;
import com.example.BE_PBL6_FastOrderSystem.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class FoodUserDetailsService implements UserDetailsService {
    private UserRepository userRepository;

    @Autowired
    public FoodUserDetailsService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String identifier) throws UsernameNotFoundException {
//        System.out.println("identifier: " + identifier);
        Optional<User> user = userRepository.findByUsernameOrSubOrFacebookId(identifier, identifier, identifier);
        if (user.isPresent()) {
            return FoodUserDetails.buildUserDetails(user.get());
        } else {
            throw new UsernameNotFoundException("User Not Found with identifier: " + identifier);
        }
    }


}