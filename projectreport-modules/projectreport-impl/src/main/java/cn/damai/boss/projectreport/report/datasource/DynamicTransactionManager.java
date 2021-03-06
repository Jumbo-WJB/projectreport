package cn.damai.boss.projectreport.report.datasource;

import javax.sql.DataSource;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTransactionManager;
import org.springframework.orm.hibernate3.SessionFactoryUtils;

public class DynamicTransactionManager extends HibernateTransactionManager {
	 
    private static final long serialVersionUID = -4655721479296819154L;
    
    /** 
     * @see org.springframework.orm.hibernate4.HibernateTransactionManager#getDataSource()
     * <b>function:</b> 重写
     * @author hoojo
     * @createDate 2013-10-12 下午03:55:24
     */
    @Override
    public DataSource getDataSource() {
        return SessionFactoryUtils.getDataSource(getSessionFactory());
    }
 
    /** 
     * @see org.springframework.orm.hibernate4.HibernateTransactionManager#getSessionFactory()
     * <b>function:</b> 重写
     * @author hoojo
     * @createDate 2013-10-12 下午03:55:24
     */
    @Override
    public SessionFactory getSessionFactory() {
        DynamicSessionFactory dynamicSessionFactory = (DynamicSessionFactory) super.getSessionFactory();  
        SessionFactory hibernateSessionFactory = dynamicSessionFactory.getHibernateSessionFactory();  
        return hibernateSessionFactory;  
    }
}