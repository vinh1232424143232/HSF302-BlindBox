package hsf.project.controller;

import hsf.project.service.SupabaseService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Controller("/img")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class SupabaseController {
    SupabaseService supabaseService;

    @PostMapping("/upload")
    public String upload(@RequestParam("file") MultipartFile file) {
        try {
            String fileName = file.getOriginalFilename();
            return supabaseService.upload(file, fileName);
        } catch (IOException e) {
            return "redirect:/error";
        }
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("filename") String filename) {
        try {
            boolean delete = supabaseService.delete(filename);
            if (delete) {
                return "redirect:/";
            } else {
                return "redirect:/error";
            }
        } catch (IOException e) {
            return "redirect:/error";
        }
    }

    @PostMapping("/get")
    public String get(@RequestParam("filename") String filename) {
        return supabaseService.getImage(filename);
    }
}
