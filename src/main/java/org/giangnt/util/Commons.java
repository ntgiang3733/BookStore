package org.giangnt.util;

import org.giangnt.model.ProductInfo;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class Commons {
    public static List<String> doUploadImage(HttpServletRequest request, ProductInfo productInfo) {
        List<String> result = new ArrayList<>();
        // thu muc upload images
        // String uploadFolderPath =
        // request.getServletContext().getRealPath("/WEB-INF/resources/img");
        String uploadFolderPath = "E:\\STUDY\\2.Java\\Project\\SpringEcommerce\\SpringMVCAnnotationShoppingShoes\\src\\main\\webapp\\WEB-INF\\resources\\img";
        System.out.println("uploadRootPath=" + uploadFolderPath);

        File uploadImgsFolderDir = new File(uploadFolderPath);

        // tao thu muc upload neu thu muc khong ton tai
        if (!uploadImgsFolderDir.exists())
            uploadImgsFolderDir.mkdirs();

        CommonsMultipartFile[] fileDatas = productInfo.getFileDatas();
        // List<File> uploadedFiles = new ArrayList<File>();
        for (CommonsMultipartFile file : fileDatas) {
            String nameWithExt = productInfo.getCode() + ".jpg";// FilenameUtils.getExtension(file.getOriginalFilename());
            try {
                // Tạo file tại Server.
                File serverFile = new File(uploadImgsFolderDir.getAbsolutePath() + File.separator + nameWithExt);
                // Luồng ghi image lên Server.
                BufferedImage originalImage = ImageIO.read(file.getInputStream());
                int type = originalImage.getType() == 0 ? BufferedImage.TYPE_INT_ARGB : originalImage.getType();

                BufferedImage resizeImageHintJpg = resizeImageWithHint(originalImage, type);
                ImageIO.write(resizeImageHintJpg, "jpg", serverFile);


                // BufferedOutputStream stream = new BufferedOutputStream(new
                // FileOutputStream(serverFile));
                // stream.write(file.getBytes());
                // stream.close();
                //
                // uploadedFiles.add(serverFile);
                // System.out.println("Write file: " + "/WEB-INF/resources/img/" serverFile);
                result.add(nameWithExt);
            } catch (Exception e) {
                System.out.println("Error Write file: " + nameWithExt);
                return null;
            }
        }
        return result;
    }

    private static BufferedImage resizeImageWithHint(BufferedImage originalImage, int type) {

        BufferedImage resizedImage = new BufferedImage(500, 500, type);
        Graphics2D g = resizedImage.createGraphics();
        g.drawImage(originalImage, 0, 0, 500, 500, null);
        g.dispose();
        g.setComposite(AlphaComposite.Src);

        g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

        return resizedImage;
    }
}
