package com.example.BE_PBL6_FastOrderSystem.repository;

import com.example.BE_PBL6_FastOrderSystem.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    boolean existsByPhoneNumber(String phoneNumber);

    Optional<User> findByPhoneNumber(String phoneNumber);

    boolean existsByEmail(String email);

    List<User> findAllByRole_Name(String roleName);

    Optional<User> findByEmail(String email);

    Optional<User> findByFacebookId(String facebookId);

    Optional<User> findBySub(String sub);

    @Query("SELECT u FROM User u WHERE u.phoneNumber = ?1 OR u.sub = ?2 OR u.facebookId = ?3")
    Optional<User> findByUsernameOrSubOrFacebookId(String username, String sub, String facebookId);
}