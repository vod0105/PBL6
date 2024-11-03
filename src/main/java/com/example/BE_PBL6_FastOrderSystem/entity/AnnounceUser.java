package com.example.BE_PBL6_FastOrderSystem.entity;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
public class AnnounceUser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long userid;
    private String title;
    private String content;

    public AnnounceUser() {
    }

    public AnnounceUser(Long id, Long userid, String title, String content) {
        this.id = id;
        this.userid = userid;
        this.title = title;
        this.content = content;
    }

    public AnnounceUser(Long userid, String title, String content) {
        this.userid = userid;
        this.title = title;
        this.content = content;
    }
}