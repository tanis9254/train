package com.egao.shicloud.framework.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author tangxi
 * @since 2020-04-23
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Position implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "position_id", type = IdType.AUTO)
    private Integer positionId;

    /**
     * 职位
     */
    private String postionName;

    private LocalDateTime createDate;


}
