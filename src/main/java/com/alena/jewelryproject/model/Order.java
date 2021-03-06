package com.alena.jewelryproject.model;

import com.alena.jewelryproject.FormatHelper;
import com.alena.jewelryproject.model.enums.DeliveryType;
import com.alena.jewelryproject.model.enums.PaymentType;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.ObjectUtils;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@NoArgsConstructor
@Entity
@Table(name = "user_order")
public class Order extends IdentifiableEntity {

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "order_jewelry",
            joinColumns = {@JoinColumn(name = "order_id")},
            inverseJoinColumns = {@JoinColumn(name = "jewelry_id")})
    private List<Jewelry> jewelries;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "promocode_id")
    private PromotionalCode promocode;

    @Enumerated(EnumType.STRING)
    @Column(name = "delivery_type")
    private DeliveryType deliveryType;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_type")
    private PaymentType paymentType;

    @Column(name = "delivery_cost")
    private Double deliveryCost;

    @Column(name = "discount")
    private Double discount;

    @Column(name = "total_cost")
    private Double totalCost;

    @Embedded
    private UserData userData;

    @Column(name = "created_date")
    private Date createdDate = new Date(System.currentTimeMillis());

    public List<Jewelry> getJewelries() {
        return jewelries;
    }

    public void setJewelries(List<Jewelry> jewelries) {
        this.jewelries = jewelries;
    }

    public PromotionalCode getPromocode() {
        return promocode;
    }

    public void setPromocode(PromotionalCode promocode) {
        this.promocode = promocode;
    }

    public DeliveryType getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(DeliveryType deliveryType) {
        this.deliveryType = deliveryType;
    }

    public PaymentType getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(PaymentType paymentType) {
        this.paymentType = paymentType;
    }

    public UserData getUserData() {
        return userData;
    }

    public void setUserData(UserData userData) {
        this.userData = userData;
    }

    public Double getDeliveryCost() {
        return deliveryCost;
    }

    public void setDeliveryCost(Double deliveryCost) {
        this.deliveryCost = deliveryCost;
    }

    public Double getDiscount() {
        return discount;
    }

    public void setDiscount(Double discount) {
        this.discount = discount;
    }

    public Double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(Double totalCost) {
        this.totalCost = totalCost;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getFormatDeliveryCost() {
        return FormatHelper.getPriceFormat(deliveryCost, FormatHelper.Currency.RUB);
    }

    public String getFormatDiscount() {
        return FormatHelper.getPriceFormat(discount, FormatHelper.Currency.RUB);
    }

    public String getFormatTotalCost() {
        return FormatHelper.getPriceFormat(totalCost, FormatHelper.Currency.RUB);
    }

    public Double getCostWithoutDiscount() {
        if (discount == null || Math.round(discount) == 0) {
            return null;
        }
        return ObjectUtils.defaultIfNull(totalCost, 0.0) + discount;
    }

    public String getFormatCostWithoutDiscount() {
        Double costWithoutDiscount = getCostWithoutDiscount();
        if (costWithoutDiscount == null) {
            return "";
        }
        return FormatHelper.getPriceFormat(
                costWithoutDiscount,
                FormatHelper.Currency.RUB);
    }

    @Override
    public String toString() {
        if (userData == null) {
            userData = new UserData();
        }
        return String.format("Order from %s %s, %s", userData.getLastName(), userData.getFirstName(), createdDate);
    }
}
