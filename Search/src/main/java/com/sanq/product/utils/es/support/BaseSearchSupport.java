package com.sanq.product.utils.es.support;

import com.sanq.product.utils.es.entity.SearchPager;
import com.sanq.product.utils.es.entity.SearchPagination;
import com.sanq.product.utils.es.listener.IBaseSearchListener;
import com.sanq.product.utils.es.listener.ISearchListener;
import org.elasticsearch.client.RestHighLevelClient;

import java.util.List;

/**
 * 检索基类
 *
 * @param <T> 增改类
 * @param <K> 查询类
 */
public interface BaseSearchSupport<T, K> {

    /**
     * 返回当前客户端
     *
     * @return
     */
    RestHighLevelClient getClient();

    /**
     * 验证当前 index 是否存在
     *
     * @param index 索引
     * @return
     */
    boolean check(String index) throws Exception;

    /**
     * 创建索引
     */
    boolean createIndex(String index, String mapping) throws Exception;

    /**
     * 通过ID获取详情
     *
     * @param index 索引
     * @param id
     * @return
     */
    K findById(String index, String id) throws Exception;

    /**
     * 保存
     *
     * @param index  索引
     * @param entity
     */
    String save(String index, T entity) throws Exception;

    /**
     * 批量保存
     *
     * @param index      索引
     * @param entityList
     */
    boolean saveList(String index, List<T> entityList) throws Exception;

    /**
     * 修改
     *
     * @param index  索引
     * @param entity
     * @return
     */
    boolean update(String index, T entity) throws Exception;

    /**
     * 删除
     *
     * @param index 索引
     * @param id
     * @return
     */
    boolean delete(String index, String id) throws Exception;

    /**
     * 批量删除
     *
     * @param index 索引
     * @param ids
     * @return
     */
    boolean deleteList(String index, List<String> ids) throws Exception;

    /**
     * 删除 索引
     *
     * @param index 索引
     * @return
     */
    boolean deleteIndex(String index) throws Exception, Exception;

    /**
     * 查询数据 分页
     *
     * @param index      索引
     * @param entity
     * @param pagination
     * @return
     */
    SearchPager<K> findListByPage(String index, K entity, SearchPagination pagination) throws Exception;

    /**
     * 查询数据 排序
     *
     * @param index
     * @param listener
     * @param pagination
     * @return
     * @throws Exception
     */
    SearchPager<K> findListByPage(String index, IBaseSearchListener listener, SearchPagination pagination) throws Exception;


    /**
     * 查询数据 排序 设置高亮
     *
     * @param index      索引
     * @param listener
     * @param pagination
     * @return
     * @throws Exception
     */
    SearchPager<K> findListByPage(String index, ISearchListener listener, SearchPagination pagination) throws Exception;

}
