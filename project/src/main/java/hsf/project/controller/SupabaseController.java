package hsf.project.controller;

import hsf.project.service.SupabaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Controller("/img")
@RequiredArgsConstructor
public class SupabaseController {
    private final SupabaseService supabaseService;

    @PostMapping("/upload")
    public String upload(@RequestParam("file") MultipartFile file) {
        try {
            String fileName = file.getOriginalFilename();
            String url = supabaseService.upload(file, fileName);
            return "redirect:/";
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
}
