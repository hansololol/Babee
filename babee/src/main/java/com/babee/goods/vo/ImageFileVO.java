package com.babee.goods.vo;

public class ImageFileVO {
   
   private int goods_id;
   private int image_id;
   private String fileName;
   private String fileKind;
   private String reg_id;
   private String detailFile;

   public ImageFileVO() {
      super();
   }

   public ImageFileVO(String fileName) {
        this.fileName = fileName;
   }


   public String getDetailFile() {
      return detailFile;
   }

   public void setDetailFile(String detailFile) {
      this.detailFile = detailFile;
   }

   public int getGoods_id() {
      return goods_id;
   }

   public void setGoods_id(int goods_id) {
      this.goods_id = goods_id;
   }

   public int getImage_id() {
      return image_id;
   }




   public void setImage_id(int image_id) {
      this.image_id = image_id;
   }




   public String getFileName() {
      return fileName;
   }

   public void setFileName(String fileName) {
      this.fileName = fileName;
   }

   


   public String getFileKind() {
      return fileKind;
   }

   public void setFileKind(String fileKind) {
      this.fileKind = fileKind;
   }

   public String getReg_id() {
      return reg_id;
   }

   public void setReg_id(String reg_id) {
      this.reg_id = reg_id;
   }


   

}