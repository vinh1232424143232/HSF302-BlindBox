package hsf.project.service;

import hsf.project.config.SupabaseConfig;
import lombok.RequiredArgsConstructor;
import okhttp3.*;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
@RequiredArgsConstructor
public class SupabaseService {
    private final OkHttpClient client = new OkHttpClient();
    private final SupabaseConfig config;

    public String upload(MultipartFile file, String name) throws IOException {
        if (!file.isEmpty()) {
            throw new IOException("File is empty");
        }
        RequestBody fileBody = RequestBody.create(
          file.getBytes(),
          MediaType.parse(file.getContentType())
        );

        MultipartBody requestBody = new  MultipartBody.Builder()
                .setType(MultipartBody.FORM)
                .addFormDataPart("file", name, fileBody)
                .build();

        Request request = new Request.Builder()
                .url(config.getUrl()+"/storage/v1/object/" + config.getBucket() + "/" + name)
                .header("Content-Type", "multipart/form-data")
                .post(requestBody)
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (response.isSuccessful()) {
                throw new IOException("Failed to upload file");
            }
            return config.getUrl()+"/storage/v1/object/" + config.getBucket() + "/" + name;
        }
    }

    public boolean delete(String name) throws IOException {
        Request request = new Request.Builder()
                .url(config.getUrl()+"/storage/v1/object/" + config.getBucket() + "/" + name)
                .delete()
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new IOException("Failed to delete file");
            }
            return true;
        }
    }

    public String getImage(String name) {
        String imageUrl = config.getUrl()+"/storage/v1/object/public" + config.getBucket() + "/" + name;

        Request request = new Request.Builder()
                .url(imageUrl)
                .head()
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (response.isSuccessful()) {
                return imageUrl;
            } else {
                throw new IOException("Failed to get image url");
            }
        } catch (IOException e) {
            return "Could not get image";
        }
    }
}
