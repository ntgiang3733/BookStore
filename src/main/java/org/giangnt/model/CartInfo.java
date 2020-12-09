package org.giangnt.model;

import java.util.ArrayList;
import java.util.List;

public class CartInfo {

    private int orderNum;
    private CustomerInfo customerInfo;
    private final List<CartLineInfo> cartLines = new ArrayList<>();

    public int getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(int orderNum) {
        this.orderNum = orderNum;
    }

    public CustomerInfo getCustomerInfo() {
        return customerInfo;
    }

    public void setCustomerInfo(CustomerInfo customerInfo) {
        this.customerInfo = customerInfo;
    }

    public List<CartLineInfo> getCartLines() {
        return cartLines;
    }

    //find product in cart
    private CartLineInfo findLineByCode(String code) {
        for(CartLineInfo line : this.cartLines) {
            if (line.getProductInfo().getCode().equals(code)) {
                return line;
            }
        }
        return null;
    }

    //add product to cart
    public void addProduct(ProductInfo productInfo, int quantity) {
        CartLineInfo cartLineInfo = findLineByCode(productInfo.getCode());
        if (cartLineInfo == null) {
            cartLineInfo = new CartLineInfo();
            cartLineInfo.setQuantity(0);
            cartLineInfo.setProductInfo(productInfo);
            this.cartLines.add(cartLineInfo);
        }

        int newQuantity = cartLineInfo.getQuantity() + quantity;
        if (newQuantity <= 0) {
            this.cartLines.remove(cartLineInfo);
        } else {
            cartLineInfo.setQuantity(newQuantity);
        }
    }

    public void validate() {};

    //update product in cart;
    private void updateProduct(String code, int quantity) {
        CartLineInfo line = this.findLineByCode(code);
        if (line != null) {
            if (quantity <= 0) {
                this.cartLines.remove(line);
            } else {
                line.setQuantity(quantity);
            }
        }
    }

    //remove product in cart
    public void removeProduct(ProductInfo productInfo) {
        CartLineInfo line = this.findLineByCode(productInfo.getCode());
        if (line != null) {
            this.cartLines.remove(line);
        }
    }

    //update quantity of product in cart
    public void updateQuantity(CartInfo cartForm) {
        if (cartForm != null) {
            List<CartLineInfo> list = cartForm.getCartLines();
            for (CartLineInfo line : list) {
                this.updateProduct(line.getProductInfo().getCode(), line.getQuantity());
            }
        }
    }

    //check cart empty
    public boolean isEmpty() {
        return this.cartLines.isEmpty();
    }

    public boolean isValidCustomer() {
        return this.customerInfo!=null && this.customerInfo.isValid();
    }

    //get all quantity product in cart
    public int getQuantityTotal() {
        int quantity = 0;
        for (CartLineInfo line : this.cartLines) {
            quantity += line.getQuantity();
        }
        return quantity;
    }

    //get total price
    public double getAmountTotal() {
        double total = 0;
        for (CartLineInfo line : this.cartLines) {
            total += line.getAmount();
        }
        return total;
    }
}
