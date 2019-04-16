package com.ebiz.cache;



public interface IReload

{



   /**

    * called to empty out a subclass of its stored data

    */

   public void clear();





   /**

    *  called to load the data

    */

   public void load() throws Exception;



}

